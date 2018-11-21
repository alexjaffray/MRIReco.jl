export SESequence, echoAmplitudes, flipAngles, numEchoes, TE

mutable struct SESequence <:AbstractSequence
  traj :: AbstractTrajectory    # readout trajectory
end

# trajectory of the Sequence
trajectory(seq::SESequence,n::Int64=1) = seq.traj

# echo amplitude due to T2-relaxation
echoAmplitudes(seq::SESequence, R1::Float64, R2::Float64) = [exp(-seq.traj.TE*R2)]

flipAngles(seq::SESequence) = [90.]

numEchoes(seq::SESequence) = 1

echoTimes(seq::SESequence) = seq.traj.TE

string(seq::SESequence) = "SE"

function encoding(seq::SESequence)
  tr_type = typeof(trajectory(seq))
  if tr_type <: Abstract2DTrajectory
    return "2D"
  elseif tr_type <: Abstract3DTrajectory
    return "3D"
  end
  return "other"
end
