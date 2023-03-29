use crate::instructions::{
    check_and_insert_nullifier, check_external_amount, close_account, create_and_check_pda,
    sol_transfer, token_transfer,
};

// Processor for deposit and withdraw logic.
#[allow(clippy::comparison_chain)]
pub fn process_instruction(
    program_id: &Pubkey,
    accounts: &[AccountInfo],
    current_instruction_index: usize,
) -> Result<(), ProgramError> {
    
}