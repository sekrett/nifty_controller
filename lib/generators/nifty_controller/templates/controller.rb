class <%= controller_class_name %>Controller < ApplicationController
  <%- if with_cancan -%>
  load_resource

  <%- end -%>
  def index
    <%- unless with_cancan -%>
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
    <%- end -%>
  end

  def show
    <%- unless with_cancan -%>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    <%- end -%>
  end

  def new
    <%- unless with_cancan -%>
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    <%- end -%>
  end

  def edit
    <%- unless with_cancan -%>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    <%- end -%>
  end

  def create
    <%- unless with_cancan -%>
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>
    <%- end -%>
    if @<%= orm_instance.save %>
        redirect_to @<%= singular_table_name %>, :notice => '<%= human_name %> was successfully created.'
    else
      render :new
    end
  end

  def update
    <%- unless with_cancan -%>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    <%- end -%>
    if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
      redirect_to @<%= singular_table_name %>, :notice => '<%= human_name %> was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    <%- unless with_cancan -%>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    <%- end -%>
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_path, :notice => '<%= human_name %> was successfully destroyed.'
  end
end
