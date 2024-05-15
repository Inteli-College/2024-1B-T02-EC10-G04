// Package api Code generated by swaggo/swag. DO NOT EDIT
package api

import "github.com/swaggo/swag"

const docTemplate = `{
    "schemes": {{ marshal .Schemes }},
    "swagger": "2.0",
    "info": {
        "description": "{{escape .Description}}",
        "title": "{{.Title}}",
        "termsOfService": "http://swagger.io/terms/",
        "contact": {
            "name": "DeVolt Team",
            "url": "https://devolt.xyz",
            "email": "henrique@mugen.builders"
        },
        "license": {
            "name": "Apache 2.0",
            "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
        },
        "version": "{{.Version}}"
    },
    "host": "{{.Host}}",
    "basePath": "{{.BasePath}}",
    "paths": {
        "/medicines": {
            "get": {
                "description": "Retrieve all Medicines entities",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Medicines"
                ],
                "summary": "Retrieve all Medicines entities",
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "type": "array",
                            "items": {
                                "$ref": "#/definitions/dto.FindMedicineOutputDTO"
                            }
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "type": "object",
                            "additionalProperties": true
                        }
                    }
                }
            },
            "post": {
                "description": "Create a new Medicine entity",
                "consumes": [
                    "application/json"
                ],
                "produces": [
                    "application/json"
                ],
                "tags": [
                    "Medicines"
                ],
                "summary": "Create a new Medicine entity",
                "parameters": [
                    {
                        "description": "Medicine entity to create",
                        "name": "input",
                        "in": "body",
                        "required": true,
                        "schema": {
                            "$ref": "#/definitions/dto.CreateMedicineInputDTO"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "schema": {
                            "$ref": "#/definitions/dto.CreateMedicineOutputDTO"
                        }
                    },
                    "400": {
                        "description": "Bad Request",
                        "schema": {
                            "type": "object",
                            "additionalProperties": true
                        }
                    },
                    "500": {
                        "description": "Internal Server Error",
                        "schema": {
                            "type": "object",
                            "additionalProperties": true
                        }
                    }
                }
            }
        }
    },
    "definitions": {
        "dto.CreateMedicineInputDTO": {
            "type": "object",
            "properties": {
                "batch": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "stripe": {
                    "$ref": "#/definitions/entity.StripeType"
                }
            }
        },
        "dto.CreateMedicineOutputDTO": {
            "type": "object",
            "properties": {
                "batch": {
                    "type": "string"
                },
                "created_at": {
                    "type": "string"
                },
                "id": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "stripe": {
                    "$ref": "#/definitions/entity.StripeType"
                },
                "updated_at": {
                    "type": "string"
                }
            }
        },
        "dto.FindMedicineOutputDTO": {
            "type": "object",
            "properties": {
                "batch": {
                    "type": "string"
                },
                "created_at": {
                    "type": "string"
                },
                "id": {
                    "type": "string"
                },
                "name": {
                    "type": "string"
                },
                "stripe": {
                    "$ref": "#/definitions/entity.StripeType"
                },
                "updated_at": {
                    "type": "string"
                }
            }
        },
        "entity.StripeType": {
            "type": "string",
            "enum": [
                "red",
                "yellow",
                "black"
            ],
            "x-enum-varnames": [
                "StripeRed",
                "StripeYellow",
                "StripeBlack"
            ]
        }
    }
}`

// SwaggerInfo holds exported Swagger Info so clients can modify it
var SwaggerInfo = &swag.Spec{
	Version:          "1.0",
	Host:             "localhost:8080",
	BasePath:         "/api/v1",
	Schemes:          []string{},
	Title:            "Devices Api Server",
	Description:      "This is the devolt api server to manage devices.",
	InfoInstanceName: "swagger",
	SwaggerTemplate:  docTemplate,
	LeftDelim:        "{{",
	RightDelim:       "}}",
}

func init() {
	swag.Register(SwaggerInfo.InstanceName(), SwaggerInfo)
}
