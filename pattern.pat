match(LHS, m_Neg(m_Value(A)))
match(RHS, m_Neg(m_Value(B)))
match(&I, m_Add(m_Specific(LHS), m_Specific(RHS)))
