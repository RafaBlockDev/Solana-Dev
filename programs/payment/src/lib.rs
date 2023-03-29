use anchor_lang::prelude::*;
use anchor_lang::solana_program::entrypoint::ProgramResult;
use chrono::{Datelike, NaiveDate, NaiveDateTime};

pub mod schema;
pub mod instructions;
use anchor_lang::solana_program::native_token::LAMPORTS_PER_SOL;

declare_id!("Fg6PaFpoGXkYsidMpWTK6W2BeZ7FEfcYkg476zPFsLnS");

#[program]
pub mod maius_payment {
    
}