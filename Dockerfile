FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY src/Monitoring.Api/Monitoring.Api.csproj src/Monitoring.Api/
RUN dotnet restore src/Monitoring.Api/Monitoring.Api.csproj
COPY src/Monitoring.Api/ src/Monitoring.Api/
RUN dotnet publish src/Monitoring.Api/Monitoring.Api.csproj -c Release -o /out --no-restore
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /out .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
USER $APP_UID
ENTRYPOINT ["dotnet", "Monitoring.Api.dll"]
