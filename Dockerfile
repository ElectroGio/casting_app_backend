
# Base
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app

EXPOSE 80
EXPOSE 443
EXPOSE 4003
EXPOSE 5003


# SDK
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia los archivos de proyecto al contenedor
COPY ["./Acanala.CastingApp.Application/Acanala.CastingApp.Application.csproj", "src/Acanala.CastingApp.Application/"]
COPY ["./Acanala.CastingApp.Domain/Acanala.CastingApp.Domain.csproj", "src/Acanala.CastingApp.Domain/"]
COPY ["./Acanala.CastingApp.Web/Acanala.CastingApp.Web.csproj", "src/Acanala.CastingApp.Web/"]
COPY ["./Acanala.CastingApp.Infrastructure/Acanala.CastingApp.Infrastructure.csproj", "src/Acanala.CastingApp.Infrastructure/"]



# Restaura las dependencias del proyecto
RUN dotnet restore "src/Acanala.CastingApp.Web/Acanala.CastingApp.Web.csproj"


# Copia el resto de los archivos al contenedor
COPY . .

# Compila los proyectos
WORKDIR "/src/Acanala.CastingApp.Web/"
RUN dotnet build -c Release -o /app/build


# Publica los proyectos
FROM build AS publish

RUN dotnet publish -c Release -o /app/publish

FROM base AS runtime

WORKDIR /app
COPY --from=publish /app/publish .
RUN ls -l

ENTRYPOINT ["dotnet", "/app/Acanala.CastingApp.Web.dll"]