"""add content column to posts table

Revision ID: d5c92e7daec2
Revises: 2ef0fec9f1d4
Create Date: 2026-03-18 14:03:52.903047

"""

from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'd5c92e7daec2'
down_revision: Union[str, Sequence[str], None] = '2ef0fec9f1d4'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    op.add_column(
        'posts',
        sa.Column('content', sa.String(), nullable=False),
    )


def downgrade() -> None:
    """Downgrade schema."""
    op.drop_column(
        'posts',
        'content',
    )
