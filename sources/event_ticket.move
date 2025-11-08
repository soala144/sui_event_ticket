module eventticket::event_ticket {
    use sui::event;
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use std::ascii;

    // Event when ticket is created or issued
    public struct TicketEvent has key, store {
        id: UID,
        event_name: ascii::String,
        seat_number: u64,
        owner: address,
    }

    // NEW: Event when ticket ownership changes
    public struct TicketTransferEvent has key, store {
        id: UID,
        event_name: ascii::String,
        seat_number: u64,
        from: address,
        to: address,
    }

    public fun emit_ticket_event(
        event_name: ascii::String,
        seat_number: u64,
        owner: address,
        ctx: &mut TxContext
    ) {
        let event = TicketEvent {
            id: object::new(ctx),
            event_name,
            seat_number,
            owner,
        };
        event::emit(event);
    }

    // NEW FUNCTION for transfer events
    public fun emit_ticket_transfer_event(
        event_name: ascii::String,
        seat_number: u64,
        from: address,
        to: address,
        ctx: &mut TxContext
    ) {
        let transfer_event = TicketTransferEvent {
            id: object::new(ctx),
            event_name,
            seat_number,
            from,
            to,
        };
        event::emit(transfer_event);
    }
}