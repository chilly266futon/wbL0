CREATE TABLE delivery (
                          id SERIAL PRIMARY KEY,

                          name TEXT NOT NULL,
                          phone TEXT NOT NULL,
                          zip TEXT NOT NULL,
                          city TEXT NOT NULL,
                          address TEXT NOT NULL,
                          region TEXT NOT NULL,
                          email TEXT NOT NULL
);

CREATE TABLE payment (
                         id SERIAL PRIMARY KEY,

                         transaction TEXT NOT NULL,
                         request_id TEXT,
                         currency TEXT NOT NULL,
                         provider TEXT NOT NULL,
                         amount INTEGER NOT NULL,
                         payment_dt INTEGER NOT NULL,
                         bank TEXT NOT NULL,
                         delivery_cost INTEGER NOT NULL,
                         goods_total INTEGER NOT NULL,
                         custom_fee INTEGER
);

CREATE TABLE items (
                       id SERIAL PRIMARY KEY,

                       chrt_id INTEGER NOT NULL,
                       track_number TEXT NOT NULL,
                       price INTEGER NOT NULL,
                       rid TEXT NOT NULL,
                       name TEXT NOT NULL,
                       sale INTEGER NOT NULL,
                       "size" TEXT NOT NULL,
                       total_price INTEGER NOT NULL,
                       nm_id INTEGER NOT NULL UNIQUE ,
                       brand TEXT NOT NULL,
                       status INTEGER NOT NULL
);

CREATE TABLE wb (
                    id SERIAL PRIMARY KEY,
                    order_uid TEXT unique,
                    track_number TEXT NOT NULL,
                    entry TEXT NOT NULL,

                    delivery_id INTEGER NOT NULL,
                    payment_id INTEGER NOT NULL,
                    items_id INTEGER NOT NULL,

                    locale TEXT NOT NULL,
                    internal_signature TEXT,
                    customer_id TEXT NOT NULL UNIQUE ,
                    delivery_service TEXT NOT NULL,
                    shardkey TEXT NOT NULL,
                    sm_id INTEGER NOT NULL,
                    date_created DATE NOT NULL,
                    oof_shard TEXT NOT NULL,

                    CONSTRAINT fk_delivery_id FOREIGN KEY (delivery_id) REFERENCES delivery(id) ON DELETE CASCADE,
                    CONSTRAINT fk_payment_id FOREIGN KEY (payment_id) REFERENCES payment(id) ON DELETE CASCADE,
                    CONSTRAINT fk_items_id FOREIGN KEY (items_id) REFERENCES items(id) ON DELETE CASCADE
);

CREATE INDEX fk_delivery_id ON wb(delivery_id);
CREATE INDEX fk_payment_id ON wb(payment_id);
CREATE INDEX fk_items_id ON wb(items_id);

CREATE TABLE wb_items (
                          id SERIAL PRIMARY KEY,
                          order_uid TEXT NOT NULL,
                          chrt_id INTEGER NOT NULL,

                          CONSTRAINT fk_order_uid FOREIGN KEY (order_uid) REFERENCES wb(order_uid) ON DELETE CASCADE,
                          CONSTRAINT fk_wb_id FOREIGN KEY (chrt_id) REFERENCES wb(id) ON DELETE CASCADE
);

CREATE INDEX fk_order_uid ON wb_items(order_uid);
CREATE INDEX fk_wb_id ON wb_items(chrt_id);
