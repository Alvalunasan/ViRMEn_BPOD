function protocol = get_test_protocol_Virmen()

protocol.mazes     = struct(...
      'lStart'          , {75   , 25    ,50     , 50    , 75    , 75     }   ...
    , 'lCue'            , {75     ,12      ,12     ,12   , 12   ,   12     }   ...
    , 'lMemory'         , {75    , 25    , 50    , 50    , 75    , 75      }   ...
    , 'tri_turnHint'    , {true  , true  , true  , true  , false  , false  }   ...
    , 'cueDuration'     , {nan   , nan   , nan   , nan   , nan   , nan   }   ... seconds
    , 'cueVisibleAt'    , {inf   , inf   , inf   , inf   , inf   , inf  }   ...
    , 'cueProbability'  , {inf   , inf   , inf   , inf   , inf   , inf  }   ...
    , 'cueDensityPerM'  , {3.8   , 3.8   , 3.8   , 3.8   , 3.8   , 3.8  }   ...
    , 'antifracion'     , {0     , 0     , 0     , 0     , 0     , 0    }   ...
    , 'world'           , {1     , 1     , 1     , 1     , 1     , 1    }   ...
    , 'stage'           , {1     , 1     , 1     , 1     , 1     , 1    }   ...
    , 'context'         , {1     , 1     , 1     , 1     , 1     , 1    }   ...
    );

protocol.criteria  = struct(...
      'numTrials'       , {60     , 6     , 6     , 6     , 6    , 6    }   ...
    , 'numTrialsPerMin' , {2     , 2     , 2     , 2     , 2    , 2    }   ...
    , 'criteriaNTrials' , {inf   , inf   , 80    , 100   , 100  , 100  }   ...
    , 'warmupNTrials'   , {[]    , []    , []    , []    , []   ,  []  }   ...
    , 'numSessions'     , {0     , 0     , 0     , 0     , 0    ,  0   }   ...
    , 'performance'     , {0.9     , 0     , 0.6   , 0.6   , 0.8  ,  0.8 }   ...
    , 'maxBias'         , {inf   , inf   , inf   , inf   , inf  ,  inf }   ...
    , 'warmupMaze'      , {[]    , []    , []    , []    , []   ,  []  }   ...
    , 'warmupPerform'   , {[]    , []    , []    , []    , []   ,  []  }   ...
    , 'warmupBias'      , {[]    , []    , []    , []    , []   ,  []  }   ...
    , 'warmupMotor'     , {[]    , []    , []    , []    , []   ,  []  }   ...
    , 'easyBlock'       , {nan   , nan   , nan   , nan   , nan  ,  nan }   ... maze ID of easy block
    , 'easyBlockNTrials', {10    , 10    , 10    , 10    , 10      10  }   ... number of trials in easy block
    , 'numBlockTrials'  , {20    , 20    , 20    , 20    , 20    , 40  }   ... number of trials for sliding window perfromance
    , 'blockPerform'    , {.7    , .7    , .7    , .7    , .7    , .7  }   ... performance threshold to go into easy block
    , 'numTrialsContext', {3     , 3     , 3     , 3     , 3    , 3    }   ...
    );

protocol.globalSettings          = {'cueMinSeparation', 12, 'fracDuplicated', 0.5, 'trialDuplication', 4};
protocol.contextSettings         = {'contextSettings', true};
protocol.globalSettings          = [protocol.globalSettings, protocol.contextSettings];

protocol.numMazesInProtocol   = numel(protocol.mazes);
protocol.stimulusGenerator    = @PoissonStimulusTrain;
protocol.stimulusParameters   = {'cueVisibleAt', 'cueDensityPerM', 'cueProbability', 'nCueSlots', 'cueMinSeparation'};
protocol.inheritedVariables   = {'cueDuration', 'cueVisibleAt', 'lCue', 'lMemory'};


protocol.virmenSensor = MovementSensor(1);
protocol.virmenDisplacementPerCm = 1;
protocol.virmenRotationsPerRev = NaN;

end

