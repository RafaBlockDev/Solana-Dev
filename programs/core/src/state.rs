use crate::utils::config::{ENCRYPTED_UTXOS_LENGTH, TMP_STORAGE_ACCOUNT_TYPE};
use crate::IX_ORDER;
use arrayref::{array_mut_ref, array_ref, array_refs, mut_array_refs};
use solana_program::{
    msg,
    program_error::ProgramError,
    program_pack::{IsInitialized, Pack, Sealed},
    pubkey::Pubkey,
};

use std::convert::TryInto;

#[derive(Clone)]
pub struct ChecksAndTransferState {
    
}