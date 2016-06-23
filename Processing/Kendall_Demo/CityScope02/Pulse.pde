// Pulse Parameters
boolean pulse = true; //sets whether pulse or not
float frameModifier = .5; //bigger makes quicker, smaller makes slower
int num_pulses = 3;
int change_rate = num_pulses*floor(0.75*(2.75*PI)/frameModifier); //frames at which data layer visualization changes
float sin = 0;
float fade = 1; // var=1 Fade completely; var=.5 Fade half; etc

void setPulse() {
  if (pulse) {
    sin = (0.5*fade*sin(frame_count*frameModifier-PI/2))+(1-0.5*fade);
  }
  else {
    sin = 1;
  }
}
