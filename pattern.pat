match(LHS, m_Sub(m_Zero(), m_Value(A)))
match(RHS, m_Sub(m_Zero(), m_Value(B)))
match(&I, m_Add(m_Specific(LHS), m_Specific(RHS)))
