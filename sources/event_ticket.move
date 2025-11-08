module event_ticket::event_ticket;

use std::ascii;

public struct EventTicket has key {
    id: UID,
    event_name: ascii::String,
    seat_number: u64,
    owner: address,
}

public fun create_ticket(
    event_name: ascii::String,
    seat_number: u64,
    ctx: &mut TxContext,
): EventTicket {
    return EventTicket {
        id: object::new(ctx),
        event_name,
        seat_number,
        owner: tx_context::sender(ctx),
    }
}

public fun transfer_ticket(ticket: EventTicket, new_owner: address) {
    transfer::transfer(ticket, new_owner);
}
