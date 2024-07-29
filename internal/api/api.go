package api

import (
	"fmt"

	"github.com/gofiber/fiber/v2"
)

func healthcheck(c *fiber.Ctx) error {
	return c.SendString("hello, world")
}

func StartAPI(port int) {
	app := fiber.New()

	app.Get("/healthcheck", healthcheck)

	localUrl := fmt.Sprintf(":%d", port)

	app.Listen(localUrl)
}
