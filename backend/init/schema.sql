CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Functions
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

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
    on_duty BOOLEAN DEFAULT true
);

-- Pyxis Table
CREATE TABLE Pyxis (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    label VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
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

-- Triggers
CREATE TRIGGER set_updated_at_before_update_medices
BEFORE UPDATE ON Medicines
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER set_updated_at_before_update_orders
BEFORE UPDATE Orders 
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER set_updated_at_before_update_blocked_users
BEFORE UPDATE Blocked_users 
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER set_updated_at_before_update_pyxis
BEFORE UPDATE Pyxis 
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER set_updated_at_before_update_users
BEFORE UPDATE Users 
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();