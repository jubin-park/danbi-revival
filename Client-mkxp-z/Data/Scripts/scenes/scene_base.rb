#==============================================================================
# ** Scene::Base
#------------------------------------------------------------------------------
#  This is a super class of all scenes within the game.
#==============================================================================

module Scene
  class Base
    #--------------------------------------------------------------------------
    # * Main
    #--------------------------------------------------------------------------
    def main
      start
      post_start
      update until is_scene_changing?
      pre_terminate
      terminate
    end
    #--------------------------------------------------------------------------
    # * Start Processing
    #--------------------------------------------------------------------------
    def start
    end
    #--------------------------------------------------------------------------
    # * Post-Start Processing
    #--------------------------------------------------------------------------
    def post_start
      perform_transition
      Input.update
    end
    #--------------------------------------------------------------------------
    # * Determine if Scene Is Changing
    #--------------------------------------------------------------------------
    def is_scene_changing?
      SceneManager.scene != self
    end
    #--------------------------------------------------------------------------
    # * Frame Update
    #--------------------------------------------------------------------------
    def update
      update_basic
    end
    #--------------------------------------------------------------------------
    # * Update Frame (Basic)
    #--------------------------------------------------------------------------
    def update_basic
      Graphics.update
      Input.update
      MUIManager.update
      $network.update if $network.has_socket?
    end
    #--------------------------------------------------------------------------
    # * Pre-Termination Processing
    #--------------------------------------------------------------------------
    def pre_terminate
    end
    #--------------------------------------------------------------------------
    # * Termination Processing
    #--------------------------------------------------------------------------
    def terminate
      Graphics.freeze
    end
    #--------------------------------------------------------------------------
    # * Execute Transition
    #--------------------------------------------------------------------------
    def perform_transition
      Graphics.transition(transition_speed)
    end
    #--------------------------------------------------------------------------
    # * Get Transition Speed
    #--------------------------------------------------------------------------
    def transition_speed
      return 20
    end
    #--------------------------------------------------------------------------
    # * Return to Calling Scene
    #--------------------------------------------------------------------------
    def return_scene
      SceneManager.return
    end
    #--------------------------------------------------------------------------
    # * Fade Out All Sounds and Graphics
    #--------------------------------------------------------------------------
    def fadeout_all(time = 1000)
      RPG::BGM.fade(time)
      RPG::BGS.fade(time)
      RPG::ME.fade(time)
      Graphics.fadeout(time * Graphics.frame_rate / 1000)
      RPG::BGM.stop
      RPG::BGS.stop
      RPG::ME.stop
    end
  end
end