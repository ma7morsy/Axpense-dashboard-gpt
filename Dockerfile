FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["Axpense.sln", "./"]
COPY ["src/Axpense.Api/Axpense.Api.csproj", "src/Axpense.Api/"]
RUN dotnet restore "src/Axpense.Api/Axpense.Api.csproj"
COPY . .
WORKDIR "/src/src/Axpense.Api"
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 8080
ENV ASPNETCORE_URLS=http://+:8080
ENTRYPOINT ["dotnet", "Axpense.Api.dll"]
