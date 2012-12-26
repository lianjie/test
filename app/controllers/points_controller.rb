$points = []
$results = []
class PointsController < ApplicationController
  
  
  # GET /points
  # GET /points.json
  def index
    @points = Point.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @points }
    end
  end

  # GET /points/1
  # GET /points/1.json
  def show
    @point = Point.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/new
  # GET /points/new.json
  def new
    @point = Point.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @point }
    end
  end

  # GET /points/1/edit
  def edit
    @point = Point.find(params[:id])
  end

  # POST /points
  # POST /points.json
  def create
    @point = Point.new(params[:point])
    
    point_plat = @point.convert
    $points<<point_plat
    
    respond_to do |format|
      if @point.save
        format.html { redirect_to @point, notice: 'Point was successfully created.' }
        format.json { render json: @point, status: :created, location: @point }
      else
        format.html { render action: "new" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /points/1
  # PUT /points/1.json
  def update
    @point = Point.find(params[:id])

    point_plat = @point.convert
    points_length = $points.length
    $points.delete_at(points_length-1)
    $points<<point_plat
    respond_to do |format|
      if @point.update_attributes(params[:point])
        format.html { redirect_to @point, notice: 'Point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point = Point.find(params[:id])
    @point.destroy
    $points.clear
    respond_to do |format|
      format.html { redirect_to points_url }
      format.json { head :no_content }
    end
  end
  
  def result
    if request.post?
      $results.clear
      @category = Float(params["category"])*1000
      @centre_lon = params["lon"]
      @centre_lat = params["lat"]
      
      @centre = Point.new
      @centre.lat = @centre_lat
      @centre.lon = @centre_lon
      @centre_plat = @centre.convert
    
      @bottom = @centre_plat.lat-@category
      @top = @centre_plat.lat+@category
      @right = @centre_plat.lon+@category
      @left = @centre_plat.lon-@category
      
      i = 0
      while i<$points.length
        if $points[i].lon>@left
          if $points[i].lon<=@right
            if $points[i].lat>@bottom
              if $points[i].lat<=@top
                points = $points[i].recover
                $results<<points
              end
            end
          end
        end
        i += 1
      end
    end
  end
end
