 Loom
加入群聊
中文 
第2章: Ownable Contracts
上一章中，您有没有发现任何安全漏洞呢？

呀！setKittyContractAddress 可见性居然申明为“外部的”（external），岂不是任何人都可以调用它！ 也就是说，任何调用该函数的人都可以更改 CryptoKitties 合约的地址，使得其他人都没法再运行我们的程序了。

我们确实是希望这个地址能够在合约中修改，但我可没说让每个人去改它呀。

要对付这样的情况，通常的做法是指定合约的“所有权” - 就是说，给它指定一个主人（没错，就是您），只有主人对它享有特权。

OpenZeppelin库的Ownable 合约
下面是一个 Ownable 合约的例子： 来自 _ OpenZeppelin _ Solidity 库的 Ownable 合约。 OpenZeppelin 是主打安保和社区审查的智能合约库，您可以在自己的 DApps中引用。等把这一课学完，您不要催我们发布下一课，最好利用这个时间把 OpenZeppelin 的网站看看，保管您会学到很多东西！

把楼下这个合约读读通，是不是还有些没见过代码？别担心，我们随后会解释。

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() public {
    owner = msg.sender;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}
下面有没有您没学过的东东？

构造函数：function Ownable()是一个 _ constructor_ (构造函数)，构造函数不是必须的，它与合约同名，构造函数一生中唯一的一次执行，就是在合约最初被创建的时候。

函数修饰符：modifier onlyOwner()。 修饰符跟函数很类似，不过是用来修饰其他已有函数用的， 在其他语句执行前，为它检查下先验条件。 在这个例子中，我们就可以写个修饰符 onlyOwner 检查下调用者，确保只有合约的主人才能运行本函数。我们下一章中会详细讲述修饰符，以及那个奇怪的_;。

indexed 关键字：别担心，我们还用不到它。

所以Ownable 合约基本都会这么干：

合约创建，构造函数先行，将其 owner 设置为msg.sender（其部署者）

为它加上一个修饰符 onlyOwner，它会限制陌生人的访问，将访问某些函数的权限锁定在 owner 上。

允许将合约所有权转让给他人。

onlyOwner 简直人见人爱，大多数人开发自己的 Solidity DApps，都是从复制/粘贴 Ownable 开始的，从它再继承出的子类，并在之上进行功能开发。

既然我们想把 setKittyContractAddress 限制为 onlyOwner ，我们也要做同样的事情。

实战演习
首先，将 Ownable 合约的代码复制一份到新文件 ownable.sol 中。 接下来，创建一个 ZombieFactory，继承 Ownable。

1.在程序中导入 ownable.sol 的内容。 如果您不记得怎么做了，参考下 zombiefeeding.sol。

2.修改 ZombieFactory 合约， 让它继承自 Ownable。 如果您不记得怎么做了，看看 zombiefeeding.sol。

zombiefactory.sol
zombiefeeding.sol
ownable.sol
1234567891011121314151617
pragma solidity ^0.4.19;

// 1. 在这里导入

// 2. 在这里继承:
contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;

高级 Solidity 理论

 高级 Solidity 理论
 BACK 2/14 NEXT 
