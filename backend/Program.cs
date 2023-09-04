var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/ping", () => "Cats Service. Version 0.1");

app.Run();