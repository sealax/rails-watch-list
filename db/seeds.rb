require "net/http"
require "json"
require "uri"

puts "Cleaning database..."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "Fetching movies from TMDb..."

url = URI("https://api.themoviedb.org/3/movie/top_rated")
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["Authorization"] = "Bearer #{ENV['TMDB_API_READ_ACCESS_TOKEN']}"

response = http.request(request)
movies = JSON.parse(response.body)["results"]

movies.each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end

puts "Created #{Movie.count} movies"
