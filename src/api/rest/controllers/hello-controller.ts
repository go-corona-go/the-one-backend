export const helloController = {
  sayHello(_req, res) {
    res.status(200).json({ hello: "world" });
  }
}