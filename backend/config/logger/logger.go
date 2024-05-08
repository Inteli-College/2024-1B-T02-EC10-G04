package logger

import (
	"github.com/sirupsen/logrus"
	"os"
)

// Log é a instância global do logger.
var Log *logrus.Logger

// Init inicializa o logger.
func Init() {
	Log = logrus.New()
	Log.SetOutput(os.Stdout)       // Define a saída padrão para o console.
	Log.SetLevel(logrus.InfoLevel) // Define o nível de log para Info.

	Log.SetFormatter(&logrus.JSONFormatter{})
}