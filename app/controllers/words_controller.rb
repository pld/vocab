class WordsController < ApplicationController
  # GET /words
  # GET /words.xml
  def index
    session_from_params(params)
    session[:language] ||= 1
    @words = Word.find_store(session)
    @language = Language.find(session[:language])
    
    @word = default_word_params
    @display_alpha_hash = display_alpha_hash
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @words }
    end
  end
  
  def reload
    session_from_params(params)
    @words = Word.find_store(session)
    render :update do |page|
      page[:word_table].reload
    end
  end
  
  def search
    session_from_params(params)
    @words = Word.familiar_prefixed_by(params[:word], session)
    
    render :update do |page|
      page[:word_table].reload
    end
  end
  
  def language
    session[:language] = params[:language][:id]
    @words = Word.find_store(session)
    render :update do |page|
      page[:word_table].reload
    end
  end
    

  # GET /words/1
  # GET /words/1.xml
  def show
    @word = Word.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @word }
    end
  end

  # GET /words/new
  # GET /words/new.xml
  def new
    @word = Word.new
    @word.language_id = session[:language]

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @word }
    end
  end

  # GET /words/1/edit
  def edit
    @word = Word.find(params[:id])
  end

  # POST /words
  # POST /words.xml
  def create
    @word = Word.new(params[:word])

    respond_to do |format|
      if @word.save
        flash[:notice] = "Word was successfully created. <a href='/words/new'>New word</a>"
        format.html { redirect_to('/words/new') }
        # format.html { redirect_to(@word) }
        format.xml  { render :xml => @word, :status => :created, :location => @word }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /words/1
  # PUT /words/1.xml
  def update
    @word = Word.find(params[:id])

    respond_to do |format|
      if @word.update_attributes(params[:word])
        flash[:notice] = 'Word was successfully updated.'
        format.html { redirect_to(@word) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @word.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.xml
  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    respond_to do |format|
      format.html { redirect_to(words_url) }
      format.xml  { head :ok }
    end
  end
  
  # GET /words/hide/0
  def toggle
    render :update do |page|
      id = params[:id].to_i
      if id == 0
        page.select('.word_definition').each do |element|
          element.toggle
        end
      else
        page["word_#{id}"].toggle
      end
    end
  end
  
  def display_alpha_hash
    letters = {}
    'a'.upto('z') do |letter|
      letters[letter] = letter
    end
    letters['(any)'] = '-'
    letters.to_a.sort
  end
  
  private
  def default_word_params
    word = Word.new
    word.definition1 = 'a'
    word.known = 3
    word
  end
  
  def session_from_params(params)
    session[:dir] = (session[:order] == params[:order] && session[:dir]) ? false : true if params[:order] || session[:dir].nil?
    if params[:order]
      session[:order] = params[:order]
      # Extended ordering directives
      session[:ext] = ", #{['word', 'updated_at', 'created_at'].reject { |item| item == session[:order] }.join(' ASC,')}"
    end
  end

end