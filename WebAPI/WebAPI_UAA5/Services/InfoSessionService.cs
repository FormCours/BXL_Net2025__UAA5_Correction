using Dapper;
using System.Data.Common;
using WebAPI_UAA5.Models;

public class InfoSessionService
{
    private readonly DbConnection _dbConnection;
    public InfoSessionService(DbConnection dbConnection)
    {
        _dbConnection = dbConnection;
    }
    
    public InfoSessionRegistration RegisterParticipant(InfoSessionRegistration data)
    {
        string sql = $@"
            INSERT INTO [info_session_registration] ( [training_session_id], [email], [newsletter_authorized])
            OUTPUT INSERTED.id
            VALUES ( @TrainingSessionId, @Email, @NewsletterAuthorized)";

        int newId = _dbConnection.ExecuteScalar<int>(sql, data);

        data.Id = newId;
        return data;
    }

    public IEnumerable<InfoSessionRegistration> GetParticipants(int trainingSessionId)
    {
        string sql = $@"
            SELECT
                [id],
                [training_session_id] AS [TrainingSessionId],
                [email] AS [Email],
                [newsletter_authorized] AS [NewsletterAuthorized],
                [registration_date] AS [RegistrationDate]
            FROM [info_session_registration]
            WHERE [training_session_id] = @SessionId
            ORDER BY [RegistrationDate]";

        return _dbConnection.Query<InfoSessionRegistration>(
            sql,
            new { SessionId = trainingSessionId }
        );
    }
}