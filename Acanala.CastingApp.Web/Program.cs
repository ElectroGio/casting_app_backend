var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var connectionString = builder.Configuration.GetConnectionString("SQLConnection");
if (connectionString != null)
{
    // builder.Services.AddDbContext<CastingAppDbContext>(x => x.UseNpgsql(connectionString));
}

//builder.Services.AddAutoMapper(typeof(Program).Assembly);
builder.Services.AddHttpContextAccessor();
builder.Services.AddLogging();

var app = builder.Build();

app.UseSwagger(options =>
{
    options.SerializeAsV2 = true;
});
app.UseSwaggerUI();

//app.UseAuthorization();
//app.UseAuthentication();
//app.MapControllers();

app.Run();