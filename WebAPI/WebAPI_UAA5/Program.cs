using Microsoft.Data.SqlClient;
using System.Data.Common;
using WebAPI_UAA5.Services;

// Connexion à la base de donnée
const string CONNECTION_STRING = "...";

// Configuration de la WebAPI
var builder = WebApplication.CreateBuilder(args);

// - Ajout des services
builder.Services.AddTransient<TrainingService>();
builder.Services.AddTransient<InfoSessionService>();

builder.Services.AddTransient<DbConnection>((provider) =>
{
    return new SqlConnection(CONNECTION_STRING);
});

// - Configuration des cors
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin();
        policy.AllowAnyHeader();
        policy.AllowAnyMethod();
    });
});

// - Ajout des controllers
builder.Services.AddControllers();

// - Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// - Génération de l'app
var app = builder.Build();


// Configuration du traitement des requetes
// - OpenAPI (en mode DEV)
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// - Utilisation des cors
app.UseCors("AllowAll");

// - Middlewares
app.UseStaticFiles();
app.UseHttpsRedirection();
app.UseAuthorization();
app.MapControllers();

// - Lancement de l'application
app.Run();
