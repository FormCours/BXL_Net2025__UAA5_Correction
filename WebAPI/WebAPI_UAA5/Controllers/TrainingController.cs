using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebAPI_UAA5.Dto;
using WebAPI_UAA5.Models;
using WebAPI_UAA5.Services;

namespace WebAPI_UAA5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TrainingController : ControllerBase
    {
        private readonly TrainingService _trainingService;
        private readonly InfoSessionService _infoSessionService;

        public TrainingController(TrainingService trainingService, InfoSessionService infoSessionService)
        {
            _trainingService = trainingService;
            _infoSessionService = infoSessionService;
        }


        [HttpGet]
        [ProducesResponseType<TrainingItemResponseDto[]>(200)]
        public IActionResult GetNextSession()
        {
            IEnumerable<TrainingSession> sessions = _trainingService.GetSessionsByStartDateRange(DateTime.Today);

            return Ok(sessions.Select(session => new TrainingItemResponseDto()
            {
                Id = session.Id,
                Formation = session.TrainingCourse!.Name,
                ShortDesc = session.TrainingCourse.ShortDesc,
                StartDate = session.StartDate,
                ThumbnailUrl = (session.TrainingCourse.Thumbnail is not null) ? "/thumbnails/" + session.TrainingCourse.Thumbnail : null
            }));
        }

        [HttpGet("{id}")]
        [ProducesResponseType<TrainingResponseDto>(200)]
        [ProducesResponseType(404)]
        public IActionResult GetSessionById(int id)
        {
            TrainingSession? session = _trainingService.GetSessionById(id);

            if (session is null)
            {
                return NotFound();
            }

            return Ok(new TrainingResponseDto()
            {
                Id = session.Id,
                Formation = session.TrainingCourse!.Name,
                Description = session.TrainingCourse.FullDesc ?? session.TrainingCourse.ShortDesc,
                StartDate = session.StartDate,
                Duration = session.TrainingCourse.Duration,
                ImageUrl = "/images/" + session.TrainingCourse.Image,
                InfoSessionDatetime = session.InfoSessionDatetime,
                Location = session.Location
            });
        }


        [HttpPost("{id}/participant")]
        [ProducesResponseType<InfoSessionResponseDto>(201)]
        [ProducesResponseType(400)]
        [ProducesResponseType(404)]
        public IActionResult RegisterParticipant(int id, InfoSessionRequestDto data)
        {
            // Vérification de la formation
            TrainingSession? trainingSession = _trainingService.GetSessionById(id);

            if (trainingSession is null)
            {
                return NotFound();
            }

            if (trainingSession.InfoSessionDatetime < DateTime.Today)
            {
                return Problem(
                    detail: "La séance d'information est déjà passé",
                    statusCode: 400
                );
            }

            // Enregistrement de l'inscription dans la base de donnée
            InfoSessionRegistration sessionRegistration = new InfoSessionRegistration()
            {
                Id = 0,
                Email = data.Email,
                RegistrationDate = null,
                NewsletterAuthorized = data.NewsletterAuthorized,
                TrainingSessionId = id
            };

            InfoSessionRegistration sessionAdded = _infoSessionService.RegisterParticipant(sessionRegistration);

            // Réponse « Created » avec les données de l'inscription créée.
            return CreatedAtAction(
                nameof(GetParticipant),
                new { id = sessionAdded.TrainingSessionId },
                new InfoSessionResponseDto()
                {
                    Id = sessionAdded.Id,
                    Email = data.Email,
                    RegistrationDate = sessionAdded.RegistrationDate,
                    NewsletterAuthorized = sessionAdded.NewsletterAuthorized,
                    TrainingSessionId = sessionAdded.TrainingSessionId
                }
            );
        }


        [HttpGet("{id}/participant")]
        [ProducesResponseType<InfoSessionItemResponseDto[]>(200)]
        [ProducesResponseType(404)]
        public IActionResult GetParticipant(int id)
        {
            // Test de garde
            TrainingSession? session = _trainingService.GetSessionById(id);
            if(session is null)
            {
                // Envois d'une réponse 404
                return NotFound();
            }

            // Récuperation des données depuis la base de donnée via le service
            IEnumerable<InfoSessionRegistration> participants = _infoSessionService.GetParticipants(id);

            // Transformation sous forme de DTO
            IEnumerable<InfoSessionItemResponseDto> result = participants.Select(participant => new InfoSessionItemResponseDto()
            {
                Id = participant.Id,
                Email = participant.Email,
                RegistrationDate = participant.RegistrationDate ?? throw new Exception("RegistrationDate is null !!!")
            });

            // Envois d'une réponse 200 avec les données
            return Ok(result);
        }
    }
}
