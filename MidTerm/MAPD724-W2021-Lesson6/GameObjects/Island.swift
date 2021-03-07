import SpriteKit
import GameplayKit

class Island: GameObject
{
    
    // constructor
    init()
    {
        super.init(imageString: "island", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // LifeCycle Functions
    
    override func CheckBounds()
    {
        if(position.x <= -730)
        {
            Reset()
        }
    }
    
    override func Reset()
    { 
        position.x = 730
        // get a pseudo-random number from -310 to 310 =
        let randomY:Int = (randomSource?.nextInt(upperBound: 620))! - 310
        position.y = CGFloat(randomY)
        isColliding = false
    }
    
    // initialization
    override func Start()
    {
        zPosition = 1
        Reset()
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
