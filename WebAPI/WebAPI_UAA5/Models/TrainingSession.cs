namespace WebAPI_UAA5.Models
{
    public class TrainingSession
    {
        public required int Id { get; set; }
        public required DateTime InfoSessionDatetime { get; set; }
        public required string Location { get; set; }
        public required DateTime StartDate { get; set; }
        public required int TrainingCourseId { get; set; }
        
        public TrainingCourse? TrainingCourse { get; set; } = null;
    }
}
