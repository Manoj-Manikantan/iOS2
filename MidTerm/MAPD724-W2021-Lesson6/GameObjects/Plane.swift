import SpriteKit
import GameplayKit

class Plane: GameObject
{
    
    // constructor
    init()
    {
        super.init(imageString: "plane", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // LifeCycle Functions
    
    override func CheckBounds()
    {
        // constrain on the left - left boundary
        if(position.x <= -310)
        {
            position.x = -310
        }
        
        // constrain on the right - right boundary
        if(position.x >= 310)
        {
            position.x = 310
        }
        
    }
    
    override func Reset()
    {
       
    }
    
    // initialization
    override func Start()
    {
        zPosition = 2
    }
    
    override func Update()
    {
        CheckBounds()
    }
    
    func TouchMove(newPos: CGPoint)
    {
        position = newPos
    }
}
