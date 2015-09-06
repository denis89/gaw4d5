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

  sql = "SELECT * FROM videos WHERE genre='#{params[:id]}'"
  @videos = @db.exec(sql)

  erb :show 
end

# Edit
get '/edit/:id' do

  sql = "SELECT * FROM videos WHERE genre='#{params[:id]}'"
  sql = sql.to_i
  @videos = @db.exec(sql)

  erb :update 
end

get '/delete/:id'  do 
     @id = params[:id]
     sql = "delete FROM videos where id = '#{@id}'"
     @db.exec(sql)
    
    redirect to '/'

end