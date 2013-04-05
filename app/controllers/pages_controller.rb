class PagesController < ApplicationController

  # GET /pages
  # GET /pages.json
  def index
    update_all
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @pages }
    end
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end


  def get_analytics_profile
     Garb::Session.login('InsertLoginHere','InsertPasswordHere')
     accounts = Garb::Account.all
     #Loop all Accounts for account_id
     accounts.each do |account|
       if account.id == 2620016-1
         #Loop all Profiles for profile_id
         account.profiles.each do |profile|
          if profile.id == 4928744
            @profile = profile
            break
          end
        end
       end
     end
   end

  def update_all
      @pages = Page.all
      @pages.each do |page|
          get_analytics_profile if !@profile
          report = Garb::Report.new(@profile)
          report.metrics :unique_pageviews
          report.dimensions :page_path
          report.filters :page_path.contains => page.url
          page.unique_pageviews = report.results.first.unique_pageviews
          page.save
        end
      end
    end