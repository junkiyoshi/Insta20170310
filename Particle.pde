class Particle
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float size;
  float max_force;
  float max_speed;
  float color_value;
  color body_color;
  
  Particle()
  {
    float x = random(-width / 2, width / 2);
    float y = random(-height / 2, height / 2);
    float z = random(-width / 2, width / 2);
    location = new PVector(0, 0, 0);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    size = 3;
    max_force = 2;
    max_speed = 12;
    color_value = random(255);
    body_color = color(color_value, 255, 255);    
  }
    
  void seek(PVector target)
  {
    PVector desired = PVector.sub(target, location);
    float distance = desired.mag();
    desired.normalize();
    if(distance < 100)
    {
      float m = map(distance, 0, 100, 0, max_speed);
      desired.mult(m);
    }else
    {   
      desired.mult(max_speed);
    }
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(max_force);
    applyForce(steer);
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  void update()
  {
    PVector future = velocity.copy();
    future.normalize();
    future.mult(100);
    future.add(location);

    float angle_1 = random(360);
    float angle_2 = random(360);
    float x = 50 * cos(radians(angle_1)) * sin(radians(angle_2)) + future.x;
    float y = 50 * sin(radians(angle_1)) * sin(radians(angle_2)) + future.y;
    float z = 50 * cos(radians(angle_2)) + future.z;
    
    seek(new PVector(x, y, z));
    
    velocity.add(acceleration);
    velocity.limit(max_speed);
    location.add(velocity);
    acceleration.mult(0);
    
    if(PVector.dist(_target, location) > _limit) 
    {  
      seek(_target);
    }
    
    color_value = (color_value + random(1, 10)) % 255;
    body_color = color(color_value, 255, 255);
  }
  
  void display()
  {
    fill(body_color);
    noStroke();
    
    pushMatrix();
    translate(location.x, location.y, location.z);
    
    sphere(size);
    
    popMatrix();
    
    stroke(body_color, 128);
    strokeWeight(1.5);
    line(location.x, location.y, location.z, _target.x, _target.y, _target.z);
  }
}