def ftoc (far_temp)
  far_temp_float = far_temp.to_f
  c_temp = (5.0/9) * (far_temp_float - 32)
  c_temp
end

def ctof (c_temp)
  c_temp_float = c_temp.to_f
  f_temp = (c_temp_float * 9/5.0) + 32
end
