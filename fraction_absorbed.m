function[absorbed] = fraction_absorbed(time,ka)
 absorbed=1-(exp(-ka*time));
end
