/**
 * This code shows the events that ioredis emits when it's struggling to connect to redis
 * when the connection breaks, this is roughly what happens:
 * 
 *   1. The "error" event is emitted
 *   2. The "close" event is emitted
 *   3. The ioredis instance's retryStrategy is invoked
 *   4. If it returns null:
 *     4.1. No reconnection attempts will be made
 *     4.2. The "end" event is emitted
 *   5. If it returns a number x:
 *     5.1. Wait x milliseconds
 *     5.2. The "reconnecting" event is emitted
 *     5.3. If the connection is successful: "connect" event is emitted
 *     5.4. Otherwise, go back to 1.
 */

const ioredis = require("ioredis");

const redis = new ioredis({
    port: 7000,
    
    /**
     * When the connection to Redis is lost, should we try to reconnect,
     * and if so, how long should we wait before attempting to reconnect?
     * 
     * NOTE: This is null by default for each node in cluster mode!
     */
    retryStrategy: (times) => {
        console.log(`Executing retry strategy (times = ${times})`);

        if (times === 3) {
            return null;
        }

        return 1000;
    },

    /**
     * If the connection to Redis is lost, how many reconnection attempts
     * should we wait for before rejecting a command? Defaults to 20
     * Setting it to null means in this example commands are never rejected,
     * this helps with testing
     */
    maxRetriesPerRequest: null,
});

(async () => {
    let reconnectionAttempts = 0;

    try {
        redis.on("connect", (event) => {
            console.log("");
            console.log("connect");
            console.log("");
        });

        redis.on("error", (event) => {
            console.log("");
            console.log("error");
            console.log("");
        });

        redis.on("close", (event) => {
            console.log("");
            console.log("close");
            console.log("");
        });

        redis.on("reconnecting", (event) => {
            console.log("");
            console.log("reconnecting");
            console.log(`Reconnection attemps: ${reconnectionAttempts++}`);
            console.log("");
        });

        redis.on("end", (event) => {
            console.log("");
            console.log("end");
            console.log("");
        });

        await redis.set("test", "1234");

        console.log("Pausing for 10 seconds, break something now!");

        await new Promise((resolve) => setTimeout(resolve, 10000));

        console.log("Resuming, fetching key...");

        const start = new Date();

        const value = await redis.get("test");

        console.log(`Fetching the key took ${new Date() - start} ms`);

        console.log("Value: ", value);
    } catch (err) {
        console.error("An error has occurred:", err);
    } finally {
        redis.disconnect();
    }
})();
