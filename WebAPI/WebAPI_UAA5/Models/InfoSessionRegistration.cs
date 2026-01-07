namespace WebAPI_UAA5.Models
{
    public class InfoSessionRegistration
    {
        public required int Id { get; set; }
        public required string Email { get; set; }
        public required bool NewsletterAuthorized { get; set; }
        public required DateTime? RegistrationDate { get; set; }
        public required int TrainingSessionId { get; set; }
    }
}
