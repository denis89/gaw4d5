require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'pg'

before do
  @db = PG.connect(dbname: 'memetube', host: 'localhost')
end

after do
  @db.close
end

# Index
get '/' do
  sql = "SELECT * FROM videos"
  @videos = @db.exec(sql)
  erb :index
end

# New
get '/new' do
  sql = "insert into videos (title, description, url, genre, year) values('#{@title}', '#{@description}', '#{@url}', '#{@genre}', '#{@year}')"
    @db.exec(sql)
  erb :create
end

# Show
get '/show/:id' do
  @id = params[:id]

  sql = "id of the video='#{@id}'"

  @url = @db.exec(sql)[0]["url"]

  erb :show 
end