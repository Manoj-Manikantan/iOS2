import SpriteKit
import GameplayKit

class Ocean: GameObject
{
    
    // constructor
    init()
    {
        super.init(imageString: "oceanSide", initialScale: 4.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // LifeCycle Functions
    
    override func CheckBounds()
    {
        if(position.x <= -293)
        {
            Reset()
        }   
    }
    
    override func Reset()
    {
        position.x = 293
    }
    
    // initialization
    override func Start()
    {
        zPosition = 0
        dx = 4.0
    }
    
    override func Update()
    {
        Move()
        CheckBounds()
    }
    
    func Move()
    {
        position.x -= dx!
    }
}
