%% Modify ViRMen world object visibilities and colors according to the current maze and trial type.
function vr = configureCues(vr)

  %% Default visibility of world objects
  vr.defaultVisibility  = vr.visibilityMask;

  %% Turn off visibility of dynamically appearing cues
  if isfield(vr, 'dynamicCueNames')
    for name = vr.dynamicCueNames
      if iscell(vr.(name{:}))
        for iCue = 1:numel(vr.(name{:}))
          vr.defaultVisibility(vr.(name{:}){iCue})  ...
                        = false;
        end
      else
        vr.defaultVisibility(vr.(name{:}))          ...
                        = false;
      end
    end
  end
  
  %% Turn off visibility of cues that are not appropriate for the trial type
  otherChoices          = setdiff(Choice.all(), vr.trialType);
  if isfield(vr, 'choiceHintNames')
    for name = vr.choiceHintNames
      for choice = otherChoices
        if iscell(vr.(name{:}))
          triangles     = vr.(name{:}){choice};
        else
          triangles     = vr.(name{:})(choice,:,:);
        end
        
        %% This can be set by adding a field in the protocol mazes struct that starts with 'tri_'
        vr.defaultVisibility(triangles)                                 ...
                        = isinf(vr.mazes(vr.mazeID).visible.(name{:}))  ...
                       && vr.mazes(vr.mazeID).visible.(name{:}) < 0     ...
                        ;
      end
    end
  end
  
  %% Special case for cues that are visible from start to end
  if ~isfinite(vr.cueVisibleAt)
    for iCue = 1:numel(vr.vtx_turnCue)
      current_cues              = 1:numel(vr.trial_info.cue_pos_cell{iCue});
      for name = vr.dynamicCueNames
        if iscell(vr.(name{:}))
          triangles     = vr.(name{:}){iCue}(:,current_cues);
        else
          triangles     = vr.(name{:})(iCue,:,current_cues);
        end
        vr.defaultVisibility(triangles)   ...
                        = true;
      end
    end
    
    if isfield(vr, 'cueAppeared')
      for iCue = 1:numel(vr.vtx_turnCue)
        vr.cueAppeared{iCue}(:)  = true;
        vr.cueOnset{iCue}(:)     = 1;
        vr.cueTime{iCue}(:)      = 0;
      end
    end
  end
  
  %% Turn off visibility of dynamic landmarks
  if isfield(vr, 'tri_landmark')
    for iLM = 1:numel(vr.tri_landmark)
      vr.defaultVisibility(vr.tri_landmark{iLM})      ...
                        = false;
    end
  end
  
  %% Change color of objects as configured for the current trial
  for name = fieldnames(vr.mazes(vr.mazeID).color)'
    for choice = ChoiceExperimentStats.CHOICES
      if iscell(vr.(name{:}))
        triangles   = vr.(name{:}){choice};
      else
        triangles   = vr.(name{:})(choice,:,:);
      end
      vr.worlds{vr.currentWorld}.surface.colors(:,triangles)    ...
                    = vr.(['clr_' name{:}]){(choice == vr.trialType) + 1, choice};
    end
  end

end
