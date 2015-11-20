class AdminController < ApplicationController
	#layout "special"
  def index
  end

  def add_items
   files=[] 
   @item = Item.create(title: params["item"]["title"], description: params["item"]["description"], price: params["item"]["price"])
   files = params["files"]
   file_length = files.length
   for i in 0..file_length-1
      uploaded_io = files[i]
      @item.images.create(name: uploaded_io.original_filename) 
      
	  File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
	    file.write(uploaded_io.read)
	  end

    #render json {msg :sucess}
   end
   
  end

  def remove_items

  end

  def manage_users
  end
end
