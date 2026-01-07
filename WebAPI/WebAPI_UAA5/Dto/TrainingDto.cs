namespace WebAPI_UAA5.Dto
{
    public class TrainingResponseDto
    {
        public required int Id { get; set; }
        public required DateTime InfoSessionDatetime { get; set; }
        public required string Location { get; set; }
        public required DateTime StartDate { get; set; }
        public required string Formation { get; set; }
        public required string Description { get; set; }
        public required string ImageUrl { get; set; }
        public required int Duration { get; set; }
    }

    public class TrainingItemResponseDto
    {
        public required int Id { get; set; }
        public required DateTime StartDate { get; set; }
        public required string Formation { get; set; }
        public required string ShortDesc { get; set; }
        public required string? ThumbnailUrl { get; set; }
    }
}