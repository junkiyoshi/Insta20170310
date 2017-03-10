import de.voidplus.leapmotion.*;

ArrayList<Particle> particles;
PVector _target;
float _limit;

LeapMotion leap;

void setup()
{
  size(800, 800, P3D);
  frameRate(30);
  blendMode(ADD);
  colorMode(HSB);
  hint(DISABLE_DEPTH_TEST);
  
  particles = new ArrayList<Particle>();
  for(int i = 0; i < 256; i++)
  {
    particles.add(new Particle());
  }
  
  leap = new LeapMotion(this);
  _target = new PVector(0, 0, 0);
  _limit = 300;
}

void draw()
{
  background(0);
  translate(width / 2, height / 2, 0);
  
  for(Hand hand : leap.getHands())
  {
    if(hand.isRight())
    {
      Finger thumb = hand.getThumb();
      Finger index = hand.getIndexFinger();
      
      float distance = PVector.dist(thumb.getPosition(), index.getPosition());
      _limit = distance * 1.5;
      
      _target = thumb.getPosition().copy().sub(width / 2, height / 2, 0);
      _target.z = thumb.getPosition().z;
    }
  }
  
  for(Particle particle : particles)
  {
    particle.update();
    particle.display();
  }
}