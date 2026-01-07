using Dapper;
using System.Data.Common;
using WebAPI_UAA5.Models;

namespace WebAPI_UAA5.Services
{
    public class TrainingService
    {
        private readonly DbConnection _dbConnection;
        public TrainingService(DbConnection dbConnection)
        {
            _dbConnection = dbConnection;
        }

        public IEnumerable<TrainingSession> GetSessionsByStartDateRange(DateTime startDate, DateTime? endDate = null)
        {
            string sql = @"
            SELECT
                ts.[id],
                ts.[training_course_id] AS [TrainingCourseId],
                ts.[info_session_datetime] AS [InfoSessionDatetime],
                ts.[location] AS [Location],
                ts.[start_date] AS [StartDate],
                tc.[id],
                tc.[name] AS [Name],
                tc.[short_desc] AS [ShortDesc],
                tc.[full_desc] AS [FullDesc],
                tc.[image] AS [Image],
                tc.[thumbnail] AS [Thumbnail],
                tc.[duration] AS [Duration]
            FROM training_session ts
            INNER JOIN training_course tc ON ts.training_course_id = tc.id
            WHERE ts.start_date >= @StartDate AND (@EndDate IS NULL OR ts.start_date <= @EndDate)
            ORDER BY ts.start_date";

            IEnumerable<TrainingSession> result = _dbConnection.Query<TrainingSession, TrainingCourse, TrainingSession>(
                sql,
                (trainingSession, trainingCourse) =>
                {
                    trainingSession.TrainingCourse = trainingCourse;
                    return trainingSession;
                },
                new { StartDate = startDate, EndDate = endDate }
            );

            return result
                .GroupBy(ts => ts.Id)
                .Select(g => g.First())
                .ToList();
        }

        public TrainingSession? GetSessionById(int id)
        {
            string sql = @"
            SELECT 
                ts.[id],
                ts.[training_course_id] AS [TrainingCourseId],
                ts.[info_session_datetime] AS [InfoSessionDatetime],
                ts.[location] AS [Location],
                ts.[start_date] AS [StartDate],
                tc.[id],
                tc.[name] AS [Name],
                tc.[short_desc] AS [ShortDesc],
                tc.[full_desc] AS [FullDesc],
                tc.[image] AS [Image],
                tc.[thumbnail] AS [Thumbnail],
                tc.[duration] AS [Duration]
            FROM training_session ts
            INNER JOIN training_course tc ON ts.training_course_id = tc.id
            WHERE ts.id = @SessionId";

            IEnumerable<TrainingSession> result = _dbConnection.Query<TrainingSession, TrainingCourse, TrainingSession>(
                sql,
                (trainingSession, trainingCourse) =>
                {
                    trainingSession.TrainingCourse = trainingCourse;
                    return trainingSession;
                },
                new { SessionId = id }
            );

            return result.SingleOrDefault();
        }
    }
}
