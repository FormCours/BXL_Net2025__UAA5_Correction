using System.ComponentModel.DataAnnotations;

namespace WebAPI_UAA5.Dto
{
    public class InfoSessionRequestDto
    {
        [Required]
        [EmailAddress]
        public required string Email { get; set; }
        public required bool NewsletterAuthorized { get; set; }
    }

    public class InfoSessionResponseDto
    {
        public required int Id { get; set; }
        public required string Email { get; set; }
        public required bool NewsletterAuthorized { get; set; }
        public required DateTime? RegistrationDate { get; set; }
        public required int TrainingSessionId { get; set; }
    }
}