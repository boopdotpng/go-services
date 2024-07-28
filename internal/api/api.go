package api

import (
	"github.com/gofiber/fiber/v2"
)

func healthcheck(c *fiber.Ctx) error {
	return c.SendString("hello, world")
}

func StartAPI() {
	app := fiber.New()

	app.Get("/healthcheck", healthcheck)

	app.Listen(":3000")
}
