# CryptoZombie---L3
Advance solidity Concepts

Let's recap:
We've added a way to update our CryptoKitties contracts
We've learned to protect core functions with onlyOwner
We've learned about gas and gas optimization
We added levels and cooldowns to our zombies
We now have functions to update a zombie's name and DNA once the zombie gets above a certain level
And finally, we now have a function to return a user's zombie army


Until now, we've covered quite a few function modifiers. It can be difficult to try to remember everything, so let's run through a quick review:

We have visibility modifiers that control when and where the function can be called from: private means it's only callable from other functions inside the contract; internal is like private but can also be called by contracts that inherit from this one; external can only be called outside the contract; and finally public can be called anywhere, both internally and externally.

We also have state modifiers, which tell us how the function interacts with the BlockChain: view tells us that by running the function, no data will be saved/changed. pure tells us that not only does the function not save any data to the blockchain, but it also doesn't read any data from the blockchain. Both of these don't cost any gas to call if they're called externally from outside the contract (but they do cost gas if called internally by another function).

Then we have custom modifiers, which we learned about in Lesson 3: onlyOwner and aboveLevel, for example. For these we can define custom logic to determine how they affect a function.

These modifiers can all be stacked together on a function definition as follows:

function test() external view onlyOwner anotherModifier { /* ... */ }
