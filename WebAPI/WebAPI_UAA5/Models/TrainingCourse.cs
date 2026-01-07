namespace WebAPI_UAA5.Models
{
    public class TrainingCourse
    {
        public required int Id { get; set; }
        public required string Name { get; set; }
        public required string ShortDesc { get; set; }
        public required string? FullDesc { get; set; }
        public required string Image { get; set; }
        public required string? Thumbnail { get; set; }
        public required int Duration { get; set; }
    }
}
