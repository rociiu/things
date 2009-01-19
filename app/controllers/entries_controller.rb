class EntriesController < ApplicationController
  before_filter :set_paginate, :only => [:index, :inbox, :today, :someday, :next, :scheduled]
  
  # GET /entries
  # GET /entries.xml
  def index
    @entries = Entry.paginate :page => @page, :per_page => @per_page, :order => 'created_at DESC'
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @entry }
    end
  end
  
  def inbox
    @selected = @status = "inbox"
    @entries = Entry.inbox
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end
  
  def today
    @selected = @status = "today"
    @entries = Entry.today
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end
  
  def next
    @selected = @status = "next"
    @entries = Entry.next
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end
  
  def scheduled
    @selected = @status = "scheduled"
    @entries = Entry.scheduled
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end
  
  def someday
    @selected = @status = "someday"
    @entries = Entry.someday
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @entries }
    end
  end
  
  # GET /entries/new
  # GET /entries/new.xml
  def new
    @selected = @status = params[:status]
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])
    #@entry.user = current_user
    
    respond_to do |format|
      if @entry.save
        if @entry.status.blank?
          redirect_path = 'entries_path'
        else
          redirect_path = @entry.status + '_entries_path'
        end
        flash[:notice] = 'New To Do was successfully created.'
        format.html { redirect_to eval(redirect_path) }
        format.xml  { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        flash[:notice] = 'Entry was successfully updated.'
        format.html { redirect_to(@entry) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to(entries_url) }
      format.xml  { head :ok }
    end
  end
end
