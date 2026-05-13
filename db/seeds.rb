require "net/http"
require "json"
require "uri"

puts "Cleaning database..."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

token = ENV.fetch("TMDB_API_READ_ACCESS_TOKEN") do
  abort "Missing TMDB_API_READ_ACCESS_TOKEN. Add it to your environment or .env file before seeding."
end

puts "Fetching movies from TMDb..."

url = URI("https://api.themoviedb.org/3/movie/top_rated")
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["Authorization"] = "Bearer #{token}"

response = http.request(request)
unless response.is_a?(Net::HTTPSuccess)
  abort "TMDb request failed with #{response.code}: #{response.message}"
end

movies = JSON.parse(response.body).fetch("results")

movies.each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    backdrop_url: "https://image.tmdb.org/t/p/w780#{movie["backdrop_path"]}",
    rating: movie["vote_average"],
  )
end

puts "Created #{Movie.count} movies"
