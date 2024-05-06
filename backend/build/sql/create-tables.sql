CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Criar tipos ENUM
CREATE TYPE role_type AS ENUM ('admin', 'user', 'collector', 'manager');
CREATE TYPE stripe_type AS ENUM ('red', 'yellow', 'black');
CREATE TYPE priority_type AS ENUM ('green', 'yellow', 'red', 'white');
CREATE TYPE status_type AS ENUM ('pending', 'ongoing', 'completed', 'refused');

-- Tabela de Usuários
CREATE TABLE Users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password TEXT NOT NULL,
    role role_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    on_duty BOOLEAN
);

-- Tabela de usuários bloqueados
CREATE TABLE Blocked_users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    blocked_by UUID NOT NULL,
    reason TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (blocked_by) REFERENCES Users(id)
);

-- Tabela de Medicamentos
CREATE TABLE Medicines (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    batch VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    stripe stripe_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Pedidos
CREATE TABLE Orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    priority priority_type NOT NULL,
    user_id UUID NOT NULL,
    observation TEXT,
    status status_type NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    medicine_id UUID NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (medicine_id) REFERENCES Medicines(id)
);

-- Tabela de Responsabilidade de Pedidos de Usuário
CREATE TABLE User_Order_responsibility (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    order_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (order_id) REFERENCES Orders(id)
);