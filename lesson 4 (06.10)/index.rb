require "sinatra"
require "pg"
require "sinatra/reloader"

require './model/todo'
require './model/product'

get "/" do
  "Hello, Sinatra"
end

not_found do
  "Sorry, we didnt found this route"
end


get "/todos" do
  @title = "My todos"

  @results = Todo.find.order("id ASC").all
  erb :index
end

get "/todo" do
  @item = Todo.new
  erb :form
end

get "/todo/:id" do
  id = params['id']
  @title = "Todo #{id}"

  @item = Todo.find.one id
  erb :form
end

post "/todo/" do

  @item = Todo.new
  @item.title = params['title']
  @item.save

  redirect to("todos")
end
post "/todo/:id" do
  id = params['id']

  @item = Todo.find.one id
  @item.title = params['title']
  puts params['done']
  if params['done'] == 'on'
    @item.done = '1'
  else
    @item.done = '0'
  end
  @item.save

  redirect to("todos")
end

delete "/todo/:id" do
  id = params['id']

  @item = Todo.find.one id
  @item.delete

  "OK"
end