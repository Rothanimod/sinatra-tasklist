require 'sinatra'
require 'make_todo'

get '/' do
  @items = Tarea.all #arreglo con todas las tareas.
  redirect '/new' if @items.empty?
  erb :index
end

get '/completadas' do
  tasks = Tarea.all
  @items = tasks.select {|item| item["done"] == true}#arreglo con las tareas hechas
  erb :index
end

get '/ncompletadas' do
  tasks = Tarea.all
  @items = tasks.select {|item| item["done"] == false}#arreglo con tareas pendientes
  erb :index
end

put '/:id' do
  Tarea.update(params[:id])
  redirect '/'
end

get '/new' do
  @title = "Crear Tarea"
  erb :new
end

post '/new' do
  Tarea.create(params[:title])
  redirect '/'
end

get '/delete/:id' do
  @item = Tarea.find(params[:id])
  puts @item
  erb :delete
end

post '/delete/:id' do
  if params.has_key?("ok")
    Tarea.destroy(params[:id])
    redirect '/'
  else
    redirect '/'
  end
end
